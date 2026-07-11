--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Aleirtt, the Ogdoadic Dark  (ID: 98787535)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Reptile
-- Level: 8
-- ATK 2000 | DEF 800
-- Setcode: 0x161
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is in your GY: You can Tribute 1 monster; Special Summon this card, then your opponent
-- can add 1 monster from their GY to their hand.
-- If this card is Special Summoned: You can target 2 of your banished monsters, including a Reptile
-- monster; return them to the GY.
-- You can only use each effect of "Aleirtt, the Ogdoadic Dark" once per turn.
--[[ __CARD_HEADER_END__ ]]

--溟界の昏闇－アレート
function c98787535.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98787535,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,98787535)
	e1:SetCost(c98787535.spcost)
	e1:SetTarget(c98787535.sptg)
	e1:SetOperation(c98787535.spop)
	c:RegisterEffect(e1)
	--return to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98787535,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,98787536)
	e2:SetTarget(c98787535.rgtg)
	e2:SetOperation(c98787535.rgop)
	c:RegisterEffect(e2)
end
function c98787535.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetReleaseGroup(tp)
	if chk==0 then return g:CheckSubGroup(aux.mzctcheckrel,1,1,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg=g:SelectSubGroup(tp,aux.mzctcheckrel,false,1,1,tp)
	aux.UseExtraReleaseCount(rg,tp)
	Duel.Release(rg,REASON_COST)
end
function c98787535.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c98787535.thfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand(1-tp)
end
function c98787535.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0
		and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c98787535.thfilter),tp,0,LOCATION_GRAVE,1,nil,tp)
		and Duel.SelectYesNo(1-tp,aux.Stringid(98787535,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(1-tp,aux.NecroValleyFilter(c98787535.thfilter),tp,0,LOCATION_GRAVE,1,1,nil,tp)
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,g)
	end
end
function c98787535.rgfilter(c,e)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
end
function c98787535.fselect(g)
	return g:IsExists(Card.IsRace,1,nil,RACE_REPTILE)
end
function c98787535.rgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(c98787535.rgfilter,tp,LOCATION_REMOVED,0,nil,e)
	if chk==0 then return g:CheckSubGroup(c98787535.fselect,2,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c98787535.fselect,false,2,2)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,2,0,0)
end
function c98787535.rgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if #g>0 then
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)
	end
end
