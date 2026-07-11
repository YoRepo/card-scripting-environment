--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: The Fabled Chawa  (ID: 29905795)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Beast
-- Level: 1
-- ATK 200 | DEF 100
-- Setcode: 0x35
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase: You can activate this effect; discard 1 "Fabled" monster, and if you do,
-- Special Summon this card from your hand.
--[[ __CARD_HEADER_END__ ]]

--魔轟神獣チャワ
function c29905795.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29905795,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c29905795.tg)
	e1:SetOperation(c29905795.op)
	c:RegisterEffect(e1)
end
function c29905795.filter(c)
	return c:IsSetCard(0x35) and c:IsType(TYPE_MONSTER)
end
function c29905795.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c29905795.filter,tp,LOCATION_HAND,0,1,e:GetHandler())
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c29905795.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=aux.ExceptThisCard(e)
	local g=Duel.GetMatchingGroup(c29905795.filter,tp,LOCATION_HAND,0,ec)
	if #g==0 and ec then
		g:AddCard(ec)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local tc=g:Select(tp,1,1,nil):GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT+REASON_DISCARD)>0 and c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
