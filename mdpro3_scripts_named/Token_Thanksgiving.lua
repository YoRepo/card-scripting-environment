--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 衍生物收获祭  (ID: 57182235)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 破坏场上所有衍生物。回复破坏衍生物数量×800的基本分。
--[[ __CARD_HEADER_END__ ]]

--トークン収穫祭
function c57182235.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c57182235.target)
	e1:SetOperation(c57182235.activate)
	c:RegisterEffect(e1)
end
function c57182235.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,TYPE_TOKEN) end
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_TOKEN)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetCount()*800)
end
function c57182235.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,TYPE_TOKEN)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	Duel.Recover(tp,ct*800,REASON_EFFECT)
end
