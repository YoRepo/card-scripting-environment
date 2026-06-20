--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 混沌超量 超巨大空中要塞 宝比伦号  (ID: 49202331)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Machine
-- Rank 11
-- ATK 3800 | DEF 4000
-- Setcode: 4211
--
-- Effect Text:
-- 11星怪兽×3
-- 这张卡战斗破坏怪兽送去墓地时，给与对方基本分破坏的怪兽的原本攻击力一半数值的伤害。此外，这张卡有「超巨大空中宫殿 钟声协和号」在作为超量素材的场合，得到以下效果。
-- ●这张卡战斗破坏怪兽的场合，可以通过把这张卡1个超量素材取除，只再1次可以继续攻击。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--CX 超巨大空中要塞バビロン
function c49202331.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,11,3)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(49202331,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdgcon)
	e1:SetTarget(c49202331.damtg)
	e1:SetOperation(c49202331.damop)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(49202331,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCountLimit(1)
	e2:SetCondition(c49202331.atcon)
	e2:SetCost(c49202331.atcost)
	e2:SetOperation(c49202331.atop)
	c:RegisterEffect(e2)
end
function c49202331.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetCard(bc)
	local dam=math.floor(bc:GetAttack()/2)
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c49202331.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		local dam=math.floor(tc:GetAttack()/2)
		if dam<0 then dam=0 end
		Duel.Damage(p,dam,REASON_EFFECT)
	end
end
function c49202331.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return aux.bdcon(e,tp,eg,ep,ev,re,r,rp) and c:IsChainAttackable()
		and c:GetOverlayGroup():IsExists(Card.IsCode,1,nil,3814632)
end
function c49202331.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c49202331.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
