--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 星遗物的守护龙  (ID: 87571563)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 254
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：这张卡的发动时，可以以自己墓地1只4星以下的龙族怪兽为对象。那个场合，那只怪兽加入手卡或特殊召唤。
-- ②：1回合1次，以自己场上1只龙族怪兽为对象才能发动。那只自己怪兽的位置向其他的自己的主要怪兽区域移动。
--[[ __CARD_HEADER_END__ ]]

--星遺物の守護竜
function c87571563.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,87571563+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c87571563.target)
	c:RegisterEffect(e1)
	--move
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87571563,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c87571563.seqtg)
	e2:SetOperation(c87571563.seqop)
	c:RegisterEffect(e2)
end
function c87571563.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_DRAGON) and (c:IsAbleToHand() or (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)))
end
function c87571563.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c87571563.spfilter(chkc,e,tp) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c87571563.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(87571563,1)) then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_GRAVE_ACTION+CATEGORY_GRAVE_SPSUMMON)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c87571563.activate)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectTarget(tp,c87571563.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c87571563.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if aux.NecroValleyNegateCheck(tc) then return end
		if not aux.NecroValleyFilter()(tc) then return end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
			and (not tc:IsAbleToHand() or Duel.SelectOption(tp,1190,1152)==1) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end
function c87571563.seqfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c87571563.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c87571563.seqfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c87571563.seqfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(87571563,2))
	Duel.SelectTarget(tp,c87571563.seqfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c87571563.seqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e)
		or Duel.GetLocationCount(tp,LOCATION_MZONE,PLAYER_NONE,0)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=math.log(s,2)
	Duel.MoveSequence(tc,nseq)
end
