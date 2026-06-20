--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 深海姬 首席女歌手  (ID: 50793215)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 7
-- ATK 1500 | DEF 2700
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：以除外的1张对方的卡为对象才能发动。从卡组把1只4星以下的水属性怪兽加入手卡或特殊召唤，作为对象的卡加入对方手卡。
-- ②：这张卡为同调素材的同调怪兽不会成为对方怪兽的效果的对象。
-- ③：这张卡被送去墓地的场合，以除外的1张自己或者对方的卡为对象才能发动。那张卡回到持有者卡组。
--[[ __CARD_HEADER_END__ ]]

--深海姫プリマドーナ
function c50793215.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50793215,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,50793215)
	e1:SetTarget(c50793215.thtg)
	e1:SetOperation(c50793215.thop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c50793215.tgcon)
	e2:SetOperation(c50793215.tgop)
	c:RegisterEffect(e2)
	--to deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(50793215,1))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,50793216)
	e3:SetTarget(c50793215.tdtg)
	e3:SetOperation(c50793215.tdop)
	c:RegisterEffect(e3)
end
function c50793215.thfilter(c,e,tp,ft)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsLevelBelow(4)
		and (c:IsAbleToHand() or (ft>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)))
end
function c50793215.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_REMOVED,1,nil)
		and Duel.IsExistingMatchingCard(c50793215.thfilter,tp,LOCATION_DECK,0,1,nil,e,tp,ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_REMOVED,1,1,nil)
end
function c50793215.thop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c50793215.thfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,ft)
	if g:GetCount()>0 then
		local sc=g:GetFirst()
		if sc then
			local res=0
			if ft>0 and sc:IsCanBeSpecialSummoned(e,0,tp,false,false)
				and (not sc:IsAbleToHand() or Duel.SelectOption(tp,1190,1152)==1) then
				res=Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
			else
				res=Duel.SendtoHand(sc,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,sc)
			end
			local tc=Duel.GetFirstTarget()
			if res~=0 and tc:IsRelateToEffect(e) then
				Duel.SendtoHand(tc,nil,REASON_EFFECT)
			end
		end
	end
end
function c50793215.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO
end
function c50793215.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50793215,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetValue(c50793215.tgval)
	e1:SetOwnerPlayer(ep)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e1,true)
end
function c50793215.tgval(e,re,rp)
	return rp==1-e:GetOwnerPlayer() and re:IsActiveType(TYPE_MONSTER)
end
function c50793215.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c50793215.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
