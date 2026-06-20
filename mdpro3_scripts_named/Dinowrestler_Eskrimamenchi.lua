--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 恐龙摔跤手·斯库利玛马门溪龙  (ID: 48372950)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 6
-- ATK 2200 | DEF 0
-- Setcode: 282
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：自己场上有「恐龙摔跤手」怪兽存在的场合，这张卡可以不用解放作召唤。
-- ②：这张卡在墓地存在，自己回合对方对怪兽的特殊召唤成功的场合，以自己墓地1只4星以下的「恐龙摔跤手」怪兽为对象才能发动。那只怪兽特殊召唤。那之后，墓地的这张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ダイナレスラー・エスクリマメンチ
function c48372950.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48372950,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c48372950.ntcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(48372950,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,48372950)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c48372950.spcon)
	e2:SetTarget(c48372950.sptg)
	e2:SetOperation(c48372950.spop)
	c:RegisterEffect(e2)
end
function c48372950.ntfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x11a)
end
function c48372950.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5)
		and Duel.IsExistingMatchingCard(c48372950.ntfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c48372950.cfilter(c,tp)
	return c:IsSummonPlayer(1-tp)
end
function c48372950.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and eg:IsExists(c48372950.cfilter,1,nil,tp)
end
function c48372950.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x11a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c48372950.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c48372950.spfilter(chkc,e,tp) end
	if chk==0 then return e:GetHandler():IsAbleToHand() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c48372950.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c48372950.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c48372950.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0
		and c:IsRelateToEffect(e) then
		Duel.BreakEffect()
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
