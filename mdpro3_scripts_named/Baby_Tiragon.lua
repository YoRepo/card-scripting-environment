--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 宝贝虎龙  (ID: 12533811)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Dragon
-- Rank 1
-- ATK 900 | DEF 900
--
-- Effect Text:
-- 1星怪兽×3
-- 自己的主要阶段1把这张卡1个超量素材取除，选择自己场上表侧表示存在的1只1星的怪兽才能发动。选择的怪兽可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--ベビー・トラゴン
function c12533811.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,3)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12533811,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c12533811.condition)
	e1:SetCost(c12533811.cost)
	e1:SetTarget(c12533811.target)
	e1:SetOperation(c12533811.operation)
	c:RegisterEffect(e1)
end
function c12533811.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c12533811.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c12533811.filter(c)
	return c:IsFaceup() and c:IsLevel(1) and c:GetEffectCount(EFFECT_DIRECT_ATTACK)==0
end
function c12533811.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c12533811.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c12533811.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c12533811.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c12533811.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
