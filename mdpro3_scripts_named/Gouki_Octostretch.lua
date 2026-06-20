--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 刚鬼 锁臂章鱼  (ID: 85008676)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 252
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：对方怪兽攻击的场合，那次伤害计算时把这张卡从手卡丢弃才能发动。那次战斗发生的对自己的战斗伤害变成一半。
-- ②：给与自己伤害的效果由对方发动时，把这张卡从手卡丢弃才能发动（伤害步骤也能发动）。那个效果让自己受到的伤害变成一半。
-- ③：这张卡从场上送去墓地的场合才能发动。从卡组把「刚鬼 锁臂章鱼」以外的1张「刚鬼」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--剛鬼マンジロック
function c85008676.initial_effect(c)
	--half damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85008676,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c85008676.damcon)
	e1:SetCost(c85008676.damcost)
	e1:SetOperation(c85008676.damop)
	c:RegisterEffect(e1)
	--half damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85008676,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_HAND)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCondition(c85008676.damcon2)
	e2:SetCost(c85008676.damcost)
	e2:SetOperation(c85008676.damop2)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(85008676,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,85008676)
	e3:SetCondition(c85008676.thcon)
	e3:SetTarget(c85008676.thtg)
	e3:SetOperation(c85008676.thop)
	c:RegisterEffect(e3)
end
function c85008676.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0 and Duel.GetAttacker()~=tp
end
function c85008676.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c85008676.damop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(HALF_DAMAGE)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c85008676.damcon2(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and aux.damcon1(e,tp,eg,ep,ev,re,r,rp)
end
function c85008676.damop2(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c85008676.damval2)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
function c85008676.damval2(e,re,val,r,rp,rc)
		local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return cid==e:GetLabel() and math.floor(val/2) or val
end
function c85008676.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c85008676.thfilter(c)
	return c:IsSetCard(0xfc) and not c:IsCode(85008676) and c:IsAbleToHand()
end
function c85008676.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85008676.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c85008676.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c85008676.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
