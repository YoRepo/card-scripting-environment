--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 废铁猎人  (ID: 55624610)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 3
-- ATK 1600 | DEF 400
-- Setcode: 36
--
-- Effect Text:
-- 1回合1次，可以选择这张卡以外的自己场上表侧表示存在的1只名字带有「废铁」的怪兽破坏，从自己卡组把1只调整送去墓地。
--[[ __CARD_HEADER_END__ ]]

--スクラップ・ハンター
function c55624610.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55624610,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c55624610.destg)
	e1:SetOperation(c55624610.desop)
	c:RegisterEffect(e1)
end
function c55624610.desfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x24)
end
function c55624610.sfilter(c)
	return c:IsType(TYPE_TUNER) and c:IsAbleToGrave()
end
function c55624610.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c55624610.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c55624610.desfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
		and Duel.IsExistingMatchingCard(c55624610.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c55624610.desfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c55624610.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=Duel.SelectMatchingCard(tp,c55624610.sfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
