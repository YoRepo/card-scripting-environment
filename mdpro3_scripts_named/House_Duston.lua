--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: House Duston  (ID: 40343749)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 1
-- ATK 0 | DEF 1000
-- Setcode: 0x80
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this face-up card on the field is destroyed by your opponent's card (either by battle, and it
-- was face-up at the start of the Damage Step, or by card effect) and sent to the Graveyard: You can
-- Special Summon any "Duston" monsters of your choice from your hand and/or Deck to anywhere on the
-- field, but you must Special Summon an equal number of monsters on each side.
--[[ __CARD_HEADER_END__ ]]

--ハウスダストン
function c40343749.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40343749,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c40343749.condition)
	e1:SetTarget(c40343749.target)
	e1:SetOperation(c40343749.operation)
	c:RegisterEffect(e1)
end
function c40343749.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_BATTLE) then
		return c:GetReasonPlayer()==1-tp and bit.band(c:GetBattlePosition(),POS_FACEUP)~=0
	end
	return rp==1-tp and c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp)
end
function c40343749.filter(c,e,tp)
	return c:IsSetCard(0x80) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function c40343749.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c40343749.filter,tp,LOCATION_DECK+LOCATION_HAND,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK+LOCATION_HAND)
end
function c40343749.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local ft1=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft1<=0 or ft2<=0 then return end
	if ft1>ft2 then ft1=ft2 end
	local g=Duel.GetMatchingGroup(c40343749.filter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,e,tp)
	local ct=math.floor(g:GetCount()/2)
	if ct==0 then return end
	if ct>ft1 then ct=ft1 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(40343749,1))
	local sg1=g:Select(tp,1,ct,nil)
	local tc=sg1:GetFirst()
	g:Sub(sg1)
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc=sg1:GetNext()
	end
	local sg2=g:Select(tp,sg1:GetCount(),sg1:GetCount(),nil)
	tc=sg2:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP)
		tc=sg2:GetNext()
	end
	Duel.SpecialSummonComplete()
end
