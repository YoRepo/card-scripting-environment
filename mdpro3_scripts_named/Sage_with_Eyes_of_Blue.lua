--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 青色眼睛的贤士  (ID: 8240199)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 1
-- ATK 0 | DEF 1500
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡召唤时才能发动。从卡组把「青色眼睛的贤士」以外的1只光属性·1星调整加入手卡。
-- ②：把这张卡从手卡丢弃，以自己场上1只效果怪兽为对象才能发动。那只怪兽送去墓地，从卡组把1只「青眼」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--青き眼の賢士
function c8240199.initial_effect(c)
	--To hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c8240199.thtg)
	e1:SetOperation(c8240199.thop)
	c:RegisterEffect(e1)
	--To grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,8240199)
	e2:SetCost(c8240199.gvcost)
	e2:SetTarget(c8240199.gvtg)
	e2:SetOperation(c8240199.gvop)
	c:RegisterEffect(e2)
end
function c8240199.thfilter(c)
	return c:IsType(TYPE_TUNER) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLevel(1) and not c:IsCode(8240199) and c:IsAbleToHand()
end
function c8240199.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c8240199.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c8240199.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c8240199.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c8240199.gvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c8240199.gvfilter(c,ft)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsAbleToGrave() and (ft>0 or c:GetSequence()<5)
end
function c8240199.spfilter(c,e,tp)
	return c:IsSetCard(0xdd) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c8240199.gvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c8240199.gvfilter(chkc,ft) end
	if chk==0 then return ft>-1 and Duel.IsExistingTarget(c8240199.gvfilter,tp,LOCATION_MZONE,0,1,nil,ft)
		and Duel.IsExistingMatchingCard(c8240199.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,c8240199.gvfilter,tp,LOCATION_MZONE,0,1,1,nil,ft)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c8240199.gvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c8240199.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,c8240199.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
			if g:GetCount()>0 then
				Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
