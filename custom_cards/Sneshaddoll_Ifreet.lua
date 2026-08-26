--[[ __CARD_HEADER_START__ ]]
-- Card: Sneshaddoll Ifreet  (ID: 99810000)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Sea Serpent
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 0x9d (Shaddoll)
--
-- Effect Text:
-- You can only use 1 effect of "Sneshaddoll Ifreet" per turn and only once that turn.
-- ① FLIP: You can target 1 other face-up monster on the field; change it to face-down Defense Position.
-- ② If this card is in your GY: You can target 3 "Shaddoll" cards in your GY and/or face-up
-- Banishment, including this card; take 1 of them and Special Summon it in face-down Defense Position
-- if it is a monster, otherwise Set it, and if you do, place the others on the bottom of the Deck in
-- any order.
--[[ __CARD_HEADER_END__ ]]

--Sneshaddoll Ifreet
local s,id,o=GetID()
function s.initial_effect(c)
	--imported from WAKE CUP! Kuro
	--(1) FLIP: target 1 other face-up monster on the field; change it to face-down Defense Position
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(id,1))
	e0:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e0:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e0:SetCountLimit(1,id)
	e0:SetTarget(s.postg)
	e0:SetOperation(s.posop)
	c:RegisterEffect(e0)
	--(2) from your GY: target 3 "Shaddoll" cards in your GY and/or face-up banishment, including this
	--card; take 1 of them (Special Summon it face-down if it is a monster, otherwise Set it), and if
	--you do, place the others on the bottom of the Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,2))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET+CATEGORY_SSET+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.tdtg)
	e1:SetOperation(s.tdop)
	c:RegisterEffect(e1)
	--let "Tohushaddoll Grysta" copy (1) from the GY
	s.shadoll_flip_effect=e0
end
--(1)
function s.setfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function s.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.setfilter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(s.setfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,s.setfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function s.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
--(2)
--the card taken: Special Summoned in face-down Defense Position if it is a monster, otherwise Set
function s.tkfilter(c,e,tp)
	if c:IsType(TYPE_MONSTER) then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
	else
		return c:IsSSetable() and (c:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
	end
end
--a "Shaddoll" card in your GY or face-up banished that can fill either role
function s.tdfilter(c,e,tp)
	return c:IsSetCard(0x9d) and c:IsFaceupEx() and c:IsCanBeEffectTarget(e)
		and (c:IsAbleToDeck() or s.tkfilter(c,e,tp))
end
--the 3 must include this card, 1 that can be taken and 2 that can be placed on the bottom of the Deck
function s.fselect(g,c,e,tp)
	return g:IsContains(c) and g:IsExists(s.tkfilter,1,nil,e,tp)
		and g:IsExists(Card.IsAbleToDeck,2,nil)
end
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return false end
	local dg=Duel.GetMatchingGroup(s.tdfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,nil,e,tp)
	if chk==0 then return dg:CheckSubGroup(s.fselect,3,3,c,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=dg:SelectSubGroup(tp,s.fselect,false,3,3,c,e,tp)
	Duel.SetTargetCard(g)
	local cat=CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET
	if g:IsExists(Card.IsType,1,nil,TYPE_SPELL+TYPE_TRAP) then cat=cat+CATEGORY_SSET end
	e:SetCategory(cat)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
	local gg=g:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
	if #gg>0 then
		Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,gg,#gg,0,0)
	end
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetsRelateToChain()
	if aux.NecroValleyNegateCheck(g) then return end
	local tg=g:Filter(aux.NecroValleyFilter(),nil)
	local sg=tg:Filter(s.tkfilter,nil,e,tp)
	if #sg==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local og=sg:Select(tp,1,1,nil)
	local tc=og:GetFirst()
	Duel.HintSelection(og)
	local res=false
	if tc:IsType(TYPE_MONSTER) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)>0 then
			Duel.ConfirmCards(1-tp,tc)
			res=true
		end
	else
		res=Duel.SSet(tp,tc)~=0
	end
	if not res then return end
	tg:Sub(og)
	local rg=tg:Filter(Card.IsAbleToDeck,nil)
	if #rg>0 then
		Duel.BreakEffect()
		aux.PlaceCardsOnDeckBottom(tp,rg)
	end
end
