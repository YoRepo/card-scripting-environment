--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 鹰身先知  (ID: 66386380)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1300 | DEF 1400
-- Setcode: 100
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：这张卡的卡名只要在场上·墓地存在当作「鹰身女郎」使用。
-- ②：自己场上有5星以上的「鹰身」怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ③：这张卡召唤·特殊召唤成功的场合才能发动。这个回合的结束阶段，从自己墓地选有「鹰身女郎三姐妹」的卡名记述的1张魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ハーピィ・オラクル
function c66386380.initial_effect(c)
	aux.AddCodeList(c,12206212)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66386380,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,66386380)
	e1:SetOperation(c66386380.regop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--change name
	aux.EnableChangeCode(c,76812113,LOCATION_MZONE+LOCATION_GRAVE)
	--Special Summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(66386380,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_HAND)
	e4:SetCountLimit(1,66386381)
	e4:SetCondition(c66386380.sscon)
	e4:SetTarget(c66386380.sstg)
	e4:SetOperation(c66386380.ssop)
	c:RegisterEffect(e4)
end
function c66386380.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c66386380.thcon)
	e1:SetOperation(c66386380.thop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c66386380.thfilter(c)
	return aux.IsCodeListed(c,12206212) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c66386380.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c66386380.thfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c66386380.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c66386380.thfilter),tp,LOCATION_GRAVE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c66386380.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x64) and c:IsLevelAbove(5)
end
function c66386380.sscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c66386380.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c66386380.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c66386380.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
