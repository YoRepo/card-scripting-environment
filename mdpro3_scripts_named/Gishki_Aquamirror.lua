--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 遗式的仪水镜  (ID: 46159582)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 26083386
--
-- Effect Text:
-- 「遗式」仪式怪兽的降临必需。
-- ①：等级合计直到变成和仪式召唤的怪兽相同为止，把自己的手卡·场上的怪兽解放，从手卡把1只「遗式」仪式怪兽仪式召唤。
-- ②：让墓地的这张卡回到卡组，以自己墓地1只「遗式」仪式怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--リチュアの儀水鏡
function c46159582.initial_effect(c)
	aux.AddRitualProcEqual2(c,c46159582.ritual_filter)
	--salvage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46159582,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c46159582.cost)
	e1:SetTarget(c46159582.tg)
	e1:SetOperation(c46159582.op)
	c:RegisterEffect(e1)
end
function c46159582.ritual_filter(c)
	return c:IsSetCard(0x3a) and bit.band(c:GetType(),0x81)==0x81
end
function c46159582.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c46159582.thfilter(c)
	return c:IsSetCard(0x3a) and bit.band(c:GetType(),0x81)==0x81 and c:IsAbleToHand()
end
function c46159582.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c46159582.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c46159582.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c46159582.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c46159582.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
