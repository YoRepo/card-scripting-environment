--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 纹章兽 双头鹰  (ID: 19310321)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1200 | DEF 1400
-- Setcode: 118
--
-- Effect Text:
-- 把墓地的这张卡从游戏中除外，选择自己场上1只没有超量素材的超量怪兽和自己墓地2只名字带有「纹章兽」的怪兽才能发动。选择的墓地的怪兽在选择的超量怪兽下面重叠作为超量素材。「纹章兽
-- 双头鹰」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--紋章獣ツインヘッド・イーグル
function c19310321.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19310321,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,19310321)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c19310321.target)
	e1:SetOperation(c19310321.activate)
	c:RegisterEffect(e1)
end
function c19310321.filter1(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()==0
end
function c19310321.filter2(c)
	return c:IsSetCard(0x76) and c:IsCanOverlay()
end
function c19310321.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c19310321.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c19310321.filter2,tp,LOCATION_GRAVE,0,2,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(19310321,1))
	local g1=Duel.SelectTarget(tp,c19310321.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g2=Duel.SelectTarget(tp,c19310321.filter2,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g2,2,0,0)
end
function c19310321.ovfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsCanOverlay()
end
function c19310321.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsImmuneToEffect(e) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c19310321.ovfilter,tc,e)
	if g:GetCount()>0 then
		Duel.Overlay(tc,g)
	end
end
