--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Farewelcome Labrynth  (ID: 32785578)
-- Type: Trap
-- Setcode: 0x117e
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a monster declares an attack, while you control a Fiend monster: Target 1 card on the field;
-- negate the attack, and if you do, destroy that targeted card, then, you can Set 1 non-"Labrynth"
-- Normal Trap from your hand or Deck.
--[[ __CARD_HEADER_END__ ]]

--フェアーウェルカム・ラビュリンス
function c32785578.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c32785578.condition)
	e1:SetTarget(c32785578.target)
	e1:SetOperation(c32785578.activate)
	c:RegisterEffect(e1)
end
function c32785578.cfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsFaceup()
end
function c32785578.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c32785578.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c32785578.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c32785578.stfilter(c)
	return c:GetType()==TYPE_TRAP and not c:IsSetCard(0x17e) and c:IsSSetable()
end
function c32785578.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local res=0
	if Duel.NegateAttack() and tc:IsRelateToEffect(e) then
		res=Duel.Destroy(tc,REASON_EFFECT)
		local g=Duel.GetMatchingGroup(c32785578.stfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
		if res>0 and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(32785578,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
			local sg=g:Select(tp,1,1,nil)
			Duel.SSet(tp,sg)
		end
	end
	aux.LabrynthDestroyOp(e,tp,res)
end
