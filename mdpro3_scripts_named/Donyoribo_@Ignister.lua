--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 阴云栗仔球@火灵天星  (ID: 14146794)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Cyberse
-- Level 1
-- ATK 300 | DEF 0
-- Setcode: 309
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己的「@火灵天星」怪兽被攻击的伤害计算时把这张卡从手卡丢弃才能发动。那次战斗发生的对自己的战斗伤害变成0。
-- ②：「@火灵天星」怪兽或者「“艾”」魔法·陷阱卡的给与对方伤害的效果发动时，把墓地的这张卡除外才能发动（伤害步骤也能发动）。那个效果给与对方的伤害变成2倍。
--[[ __CARD_HEADER_END__ ]]

--ドンヨリボー＠イグニスター
function c14146794.initial_effect(c)
	--battle damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14146794,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,14146794)
	e1:SetCondition(c14146794.damcon1)
	e1:SetCost(c14146794.damcost1)
	e1:SetOperation(c14146794.damop1)
	c:RegisterEffect(e1)
	--effect damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(14146794,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCountLimit(1,14146795)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c14146794.damcon2)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c14146794.damop2)
	c:RegisterEffect(e2)
end
function c14146794.damcon1(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsControler(tp) and d:IsSetCard(0x135) and Duel.GetBattleDamage(tp)>0
end
function c14146794.damcost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c14146794.damop1(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c14146794.damcon2(e,tp,eg,ep,ev,re,r,rp)
	return ((re:GetHandler():IsSetCard(0x135) and re:IsActiveType(TYPE_MONSTER)) or (re:GetHandler():IsSetCard(0x136) and re:IsActiveType(TYPE_SPELL+TYPE_TRAP)))
		and aux.damcon1(e,1-tp,eg,ep,ev,re,r,rp)
end
function c14146794.damop2(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetLabel(cid)
	e1:SetValue(c14146794.damval2)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
function c14146794.damval2(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	return cid==e:GetLabel() and val*2 or val
end
