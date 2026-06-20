--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 白衣怪盗  (ID: 15150365)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 1000 | DEF 700
--
-- Effect Text:
-- 这张卡造成对方玩家基本分伤害的时候，对方随机丢弃1张卡。
--[[ __CARD_HEADER_END__ ]]

--白い泥棒
function c15150365.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15150365,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c15150365.condition)
	e1:SetTarget(c15150365.target)
	e1:SetOperation(c15150365.operation)
	c:RegisterEffect(e1)
end
function c15150365.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c15150365.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,0,0,1-tp,1)
end
function c15150365.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	local sg=g:RandomSelect(ep,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
