--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 时间潜行者规范针表犬  (ID: 19891131)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 600 | DEF 200
-- Setcode: 294
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上没有这张卡以外的怪兽存在的场合，把这张卡解放才能发动。从卡组把「时间潜行者规范针表犬」以外的2只「时间潜行者」怪兽守备表示特殊召唤（同名卡最多1张）。
-- ②：这张卡在墓地存在的状态，自己的超量怪兽被战斗破坏时才能发动。这张卡特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--クロノダイバー・レギュレーター
function c19891131.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19891131,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,19891131)
	e1:SetCondition(c19891131.spcon)
	e1:SetCost(c19891131.spcost)
	e1:SetTarget(c19891131.sptg)
	e1:SetOperation(c19891131.spop)
	c:RegisterEffect(e1)
	--spsummon from grave
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(19891131,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,19891132)
	e2:SetCondition(c19891131.spcon2)
	e2:SetTarget(c19891131.sptg2)
	e2:SetOperation(c19891131.spop2)
	c:RegisterEffect(e2)
end
function c19891131.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1
end
function c19891131.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST+REASON_RELEASE)
end
function c19891131.spfilter(c,e,tp)
	return c:IsSetCard(0x126) and not c:IsCode(19891131) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c19891131.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c19891131.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
		return Duel.GetMZoneCount(tp,e:GetHandler())>=2 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and g:GetClassCount(Card.GetCode)>=2
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c19891131.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c19891131.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectSubGroup(tp,aux.dncheck,false,2,2)
	if sg then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c19891131.cfilter(c,tp)
	return c:IsType(TYPE_XYZ) and c:IsPreviousControler(tp)
end
function c19891131.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c19891131.cfilter,1,nil,tp)
end
function c19891131.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c19891131.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		c:RegisterEffect(e1,true)
	end
end
