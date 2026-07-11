--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Exodius the Ultimate Forbidden Lord  (ID: 13893596)
-- Type: Monster / Effect / Special Summon
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 10
-- ATK ? | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned/Set.
-- Must be Special Summoned (from your hand) by shuffling all monsters in your GY into the Deck/Extra
-- Deck.
-- When this card declares an attack: Send 1 monster from your hand or Deck to the GY.
-- Gains 1000 ATK for each Normal Monster in your GY.
-- If this face-up card would leave the field, banish it instead.
-- If there are 5 different "Forbidden One" cards in your GY that were sent there by this card's
-- effect, you win the Duel.
--[[ __CARD_HEADER_END__ ]]

--究極封印神エクゾディオス
function c13893596.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c13893596.spcon)
	e2:SetOperation(c13893596.spop)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13893596,0))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetTarget(c13893596.tgtg)
	e3:SetOperation(c13893596.tgop)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(c13893596.atkval)
	c:RegisterEffect(e4)
	--redirect
	aux.AddBanishRedirect(c)
end
function c13893596.cfilter(c)
	return not c:IsAbleToDeckOrExtraAsCost()
end
function c13893596.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()>0
		and not g:IsExists(c13893596.cfilter,1,nil)
end
function c13893596.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_SPSUMMON)
end
function c13893596.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c13893596.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c13893596.filter(c,rc)
	return c:IsRelateToCard(rc) and c:IsSetCard(0x40) and c:IsType(TYPE_MONSTER)
end
function c13893596.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local c=e:GetHandler()
	local g=Duel.SelectMatchingCard(tp,c13893596.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE) and c:IsRelateToEffect(e) then
		tc:CreateRelation(c,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		local g=Duel.GetMatchingGroup(c13893596.filter,tp,LOCATION_GRAVE,0,nil,c)
		if c:GetOriginalCode()==13893596 and c:IsFaceup() and g:IsContains(tc) and g:GetClassCount(Card.GetCode)==5 then
			local WIN_REASON_EXODIUS = 0x14
			Duel.Win(tp,WIN_REASON_EXODIUS)
		end
	end
end
function c13893596.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,nil,TYPE_NORMAL)*1000
end
