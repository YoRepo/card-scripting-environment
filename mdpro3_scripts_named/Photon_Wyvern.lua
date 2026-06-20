--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 光子翼龙  (ID: 55758589)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 7
-- ATK 2500 | DEF 2000
-- Setcode: 85
--
-- Effect Text:
-- ①：这张卡召唤·反转召唤成功的场合发动。对方场上盖放的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--フォトン・ワイバーン
function c55758589.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55758589,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c55758589.destg)
	e1:SetOperation(c55758589.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c55758589.filter(c)
	return c:IsFacedown()
end
function c55758589.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c55758589.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c55758589.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c55758589.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
