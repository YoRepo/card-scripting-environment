--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Hyper-Ancient Shark Megalodon  (ID: 10532969)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 8
-- ATK 2900 | DEF 1300
-- Setcode: 0x1b8
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card inflicts battle damage to your opponent: You can target 1 monster your opponent
-- controls; destroy that target.
--[[ __CARD_HEADER_END__ ]]

--エンシェント・シャーク ハイパー・メガロドン
function c10532969.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10532969,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c10532969.condition)
	e1:SetTarget(c10532969.target)
	e1:SetOperation(c10532969.operation)
	c:RegisterEffect(e1)
end
function c10532969.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c10532969.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c10532969.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
