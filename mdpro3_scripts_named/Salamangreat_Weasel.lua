--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 转生炎兽 鼬鼠  (ID: 57357130)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Cyberse
-- Level 3
-- ATK 700 | DEF 1400
-- Setcode: 281
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己墓地的「转生炎兽」怪兽是2只以上的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡在墓地存在的状态，自己场上有「转生炎兽」仪式·融合·同调·超量·连接怪兽特殊召唤的场合，以这张卡以外的自己墓地1只「转生炎兽」怪兽为对象才能发动。这张卡回到卡组最下面，作为对象的怪兽在对方场
-- 上特殊召唤。那之后，自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣ウィーゼル
local s,id,o=GetID()
function s.initial_effect(c)
	--same effect send this card to grave and spsummon another card check
	local e0=aux.AddThisCardInGraveAlreadyCheck(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--special summon and draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetLabelObject(e0)
	e2:SetCondition(s.spdcon)
	e2:SetTarget(s.spdtg)
	e2:SetOperation(s.spdpop)
	c:RegisterEffect(e2)
end
function s.spfilter(c)
	return c:IsSetCard(0x119) and c:IsType(TYPE_MONSTER)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_GRAVE,0,2,nil)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function s.cfilter(c,tp,se)
	return c:IsFaceup() and c:IsControler(tp) and c:IsSetCard(0x119) and c:IsType(TYPE_FUSION+TYPE_RITUAL+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK)
		and (se==nil or c:GetReasonEffect()~=se)
end
function s.spdcon(e,tp,eg,ep,ev,re,r,rp)
	local se=e:GetLabelObject():GetLabelObject()
	return eg:IsExists(s.cfilter,1,nil,tp,se)
end
function s.spdfilter(c,e,tp)
	return c:IsSetCard(0x119) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
end
function s.spdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and s.spdfilter(chkc,e,tp) and chkc~=c end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and Duel.IsExistingTarget(s.spdfilter,tp,LOCATION_GRAVE,0,1,c,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,s.spdfilter,tp,LOCATION_GRAVE,0,1,1,c,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.spdpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and Duel.SendtoDeck(c,nil,SEQ_DECKBOTTOM,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_DECK)
		and tc:IsRelateToEffect(e) and Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_FACEUP)>0
		and Duel.IsPlayerCanDraw(tp) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
