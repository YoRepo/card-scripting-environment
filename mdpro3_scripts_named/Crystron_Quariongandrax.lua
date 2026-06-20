--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 水晶机巧-中枢大蛇  (ID: 13455674)
-- Type: Monster / Effect / Synchro
-- Attribute: WATER
-- Race: Machine
-- Level 9
-- ATK 3000 | DEF 3000
-- Setcode: 234
--
-- Effect Text:
-- 调整2只以上＋调整以外的怪兽1只
-- ①：这张卡同调召唤的场合，以最多有那些作为同调素材的怪兽数量的对方的场上·墓地的怪兽为对象才能发动。那些怪兽除外。
-- ②：同调召唤的这张卡被战斗·效果破坏的场合，以这张卡以外的自己或对方的除外状态的1只怪兽为对象才能发动。那只怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--水晶機巧－グリオンガンド
function c13455674.initial_effect(c)
	--synchro summon
	aux.AddSynchroMixProcedure(c,aux.NonTuner(nil),nil,nil,aux.Tuner(nil),2,99)
	c:EnableReviveLimit()
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13455674,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c13455674.rmcon)
	e2:SetTarget(c13455674.rmtg)
	e2:SetOperation(c13455674.rmop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13455674,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c13455674.spcon)
	e3:SetTarget(c13455674.sptg)
	e3:SetOperation(c13455674.spop)
	c:RegisterEffect(e3)
	--double tuner
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(21142671)
	c:RegisterEffect(e4)
end
function c13455674.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c13455674.rmfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c13455674.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=e:GetHandler():GetMaterialCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_MZONE) and chkc:IsControler(1-tp) and c13455674.rmfilter(chkc) end
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c13455674.rmfilter,tp,0,LOCATION_GRAVE+LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=aux.SelectTargetFromFieldFirst(tp,c13455674.rmfilter,tp,0,LOCATION_GRAVE+LOCATION_MZONE,1,ct,nil)
	if g:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),1-tp,LOCATION_GRAVE)
	else
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	end
end
function c13455674.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
function c13455674.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_SYNCHRO) and bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0
end
function c13455674.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c13455674.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c13455674.spfilter(chkc,e,tp) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c13455674.spfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,e:GetHandler(),e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c13455674.spfilter,tp,LOCATION_REMOVED,LOCATION_REMOVED,1,1,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c13455674.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
