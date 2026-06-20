--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 猫鲨  (ID: 84224627)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Beast
-- Rank 2
-- ATK 500 | DEF 500
--
-- Effect Text:
-- 2星怪兽×2
-- ①：这张卡持有水属性怪兽作为超量素材的场合，这张卡不会被战斗破坏。
-- ②：1回合1次，把这张卡1个超量素材取除，以自己场上1只4阶以下的超量怪兽为对象才能发动。那只怪兽的攻击力·守备力直到回合结束时变成原本数值的2倍。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--キャット・シャーク
function c84224627.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,2)
	c:EnableReviveLimit()
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c84224627.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--double
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84224627,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCountLimit(1)
	e2:SetCondition(aux.dscon)
	e2:SetCost(c84224627.cost)
	e2:SetTarget(c84224627.target)
	e2:SetOperation(c84224627.operation)
	c:RegisterEffect(e2)
end
function c84224627.indcon(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_WATER)
end
function c84224627.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c84224627.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsRankBelow(4)
end
function c84224627.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c84224627.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c84224627.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c84224627.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c84224627.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetBaseAttack()*2)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(tc:GetBaseDefense()*2)
		tc:RegisterEffect(e2)
	end
end
