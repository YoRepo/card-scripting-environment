--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Totem Five  (ID: 56346071)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Rock
-- Level: 3
-- ATK 500 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If 5 monsters are Special Summoned at the same time, including this card: Destroy as many cards your
-- opponent controls as possible, and if you do, inflict 500 damage to your opponent for each card
-- destroyed.
--[[ __CARD_HEADER_END__ ]]

--トーテム・ファイブ
function c56346071.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c56346071.descon)
	e1:SetTarget(c56346071.destg)
	e1:SetOperation(c56346071.desop)
	c:RegisterEffect(e1)
end
function c56346071.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()==5 and eg:IsContains(e:GetHandler())
end
function c56346071.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c56346071.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local sg=Duel.GetOperatedGroup()
	if sg:GetCount()>0 then
		Duel.Damage(1-tp,sg:GetCount()*500,REASON_EFFECT)
	end
end
