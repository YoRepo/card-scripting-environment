--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 电气金鱼  (ID: 18407024)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Thunder
-- Level 2
-- ATK 100 | DEF 0
-- Setcode: 14
--
-- Effect Text:
-- 这张卡直接攻击给与对方基本分战斗伤害时，对方选择1张手卡丢弃。
--[[ __CARD_HEADER_END__ ]]

--エレキンギョ
function c18407024.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18407024,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c18407024.condition)
	e1:SetTarget(c18407024.target)
	e1:SetOperation(c18407024.operation)
	c:RegisterEffect(e1)
end
function c18407024.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c18407024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c18407024.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
	local sg=g:Select(1-tp,1,1,nil)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
