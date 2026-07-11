--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Madolche Teacher Glassouffle  (ID: 20343502)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Fairy
-- Rank: 4
-- ATK 1800 | DEF 2500
-- Setcode: 0x71
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 4 "Madolche" monsters
-- (Quick Effect): You can detach 1 material from this card, then target 1 "Madolche" monster on the
-- field; this turn, that face-up monster is unaffected by monster effects, except its own.
-- If a "Madolche" card is sent to your GY while this card is on the field (except during the Damage
-- Step): You can shuffle up to 2 cards from the GYs into the Deck(s).
-- You can only use each effect of "Madolche Teacher Glassouffle" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ティーチャーマドルチェ・グラスフレ
function c20343502.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x71),4,2)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20343502,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,20343502)
	e1:SetCost(c20343502.cost)
	e1:SetTarget(c20343502.target)
	e1:SetOperation(c20343502.operation)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(20343502,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,20343503)
	e2:SetCondition(c20343502.tdcon)
	e2:SetTarget(c20343502.tdtg)
	e2:SetOperation(c20343502.tdop)
	c:RegisterEffect(e2)
end
function c20343502.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c20343502.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x71)
end
function c20343502.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c20343502.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c20343502.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c20343502.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c20343502.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(c20343502.efilter)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c20343502.efilter(e,re)
	return e:GetHandler()~=re:GetOwner() and re:IsActiveType(TYPE_MONSTER)
end
function c20343502.tgfilter(c,tp)
	return c:IsControler(tp) and c:IsSetCard(0x71)
end
function c20343502.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20343502.tgfilter,1,nil,tp)
end
function c20343502.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,PLAYER_ALL,LOCATION_GRAVE)
end
function c20343502.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(Card.IsAbleToDeck),tp,LOCATION_GRAVE,LOCATION_GRAVE,1,2,nil)
	if #g>0 then
		Duel.HintSelection(g)
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
