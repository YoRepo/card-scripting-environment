--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 龙剑士 雾动轰·输力  (ID: 28720123)
-- Type: Monster / Effect / Pendulum
-- Attribute: WATER
-- Race: Machine
-- Level 4
-- Pendulum Scales: L6 / R6
-- ATK 1700 | DEF 1800
-- Setcode: 14155975
--
-- Effect Text:
-- ←6 【灵摆】 6→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：以另一边的自己的灵摆区域1张「龙剑士」卡或「雾动机龙」卡为对象才能发动。那张卡特殊召唤。
-- 【怪兽效果】
-- 这个卡名在规则上也当作「雾动机龙」卡使用。这个卡名的怪兽效果1回合只能使用1次。
-- ①：这张卡被解放的场合才能发动。除「龙剑士 雾动轰·输力」外的1只「龙剑士」灵摆怪兽或「雾动机龙」灵摆怪兽从自己的额外卡组（表侧）加入手卡。
--[[ __CARD_HEADER_END__ ]]

--竜剣士ダイナマイトP
function c28720123.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,28720123)
	e1:SetTarget(c28720123.sptg)
	e1:SetOperation(c28720123.spop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,28720124)
	e2:SetTarget(c28720123.thtg)
	e2:SetOperation(c28720123.thop)
	c:RegisterEffect(e2)
end
function c28720123.spfilter(c,e,tp)
	return c:IsSetCard(0xc7,0xd8) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c28720123.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_PZONE) and chkc~=c and c28720123.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c28720123.spfilter,tp,LOCATION_PZONE,0,1,c,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c28720123.spfilter,tp,LOCATION_PZONE,0,1,1,c,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c28720123.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c28720123.thfilter(c)
	return c:IsSetCard(0xc7,0xd8) and not c:IsCode(28720123) and c:IsType(TYPE_PENDULUM) and c:IsFaceup() and c:IsAbleToHand()
end
function c28720123.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c28720123.thfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c28720123.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c28720123.thfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
