--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Abyss Actor - Super Producer  (ID: 47404795)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Fiend
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 1600
-- Setcode: 0x10ec
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 monsters, including a Fiend monster
-- During the Main Phase (Quick Effect): You can target 1 face-up card you control; destroy it, then
-- you can apply 1 of these effects.
-- ● Place 1 "Abyss Playhouse - Fantastic Theater" from your Deck, face-up in your Field Zone.
-- ● Place 1 "Abyss Actor" Pendulum Monster from your Deck in your Pendulum Zone.
-- You can only use this effect of "Abyss Actor - Super Producer" once per turn.
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－スーパー・プロデューサー
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,77297908)
	c:EnableReviveLimit()
	--material
	aux.AddLinkProcedure(c,nil,2,2,s.lchk)
	--place from deck to field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,1))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,id)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(s.dtfcon)
	e1:SetTarget(s.dtftg)
	e1:SetOperation(s.dtfop)
	c:RegisterEffect(e1)
end
function s.lchk(g)
	return g:IsExists(Card.IsLinkRace,1,nil,RACE_FIEND)
end
function s.dtfcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function s.filter(c,tp)
	return (c:IsCode(77297908) or c:IsSetCard(0x10ec) and c:IsType(TYPE_PENDULUM)
			and (Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1)))
		and not c:IsForbidden() and c:CheckUniqueOnField(tp)
end
function s.dtftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.dtfop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or Duel.Destroy(tc,REASON_EFFECT)==0 then return end
	if Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
		local sc=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
		local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if sc:IsType(TYPE_FIELD) and fc then
			Duel.SendtoGrave(fc,REASON_RULE)
			Duel.BreakEffect()
		end
		local loc=sc:IsType(TYPE_FIELD) and LOCATION_FZONE or LOCATION_PZONE
		Duel.MoveToField(sc,tp,tp,loc,POS_FACEUP,true)
	end
end
