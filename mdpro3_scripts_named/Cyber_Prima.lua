--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 电子化女主角  (ID: 2158562)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 6
-- ATK 2300 | DEF 1600
-- Setcode: 147
--
-- Effect Text:
-- ①：这张卡上级召唤的场合发动。场上的表侧表示的魔法卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--サイバー・プリマ
function c2158562.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2158562,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c2158562.descon)
	e1:SetTarget(c2158562.destg)
	e1:SetOperation(c2158562.desop)
	c:RegisterEffect(e1)
end
function c2158562.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c2158562.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL)
end
function c2158562.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c2158562.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c2158562.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c2158562.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
