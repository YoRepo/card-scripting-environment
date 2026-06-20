--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 地狱猎犬猛龙  (ID: 86239173)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Dinosaur
-- Level 6
-- ATK 2000 | DEF 1800
--
-- Effect Text:
-- 「地狱猛禽翼龙」＋恐龙族·龙族怪兽
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：这张卡融合召唤的场合才能发动。从自己的卡组·墓地把1张场地魔法卡在自己的场地区域表侧表示放置。
-- ②：这张卡在特殊召唤的回合可以直接攻击。
-- ③：自己主要阶段才能发动。进行1只恐龙族或龙族的怪兽的召唤。
--[[ __CARD_HEADER_END__ ]]

--ヘルホーンドザウルス
function c86239173.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,50834074,c86239173.matfilter,1,true,true)
	--move field
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86239173,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,86239173)
	e1:SetCondition(c86239173.con)
	e1:SetTarget(c86239173.tg)
	e1:SetOperation(c86239173.op)
	c:RegisterEffect(e1)
	--direct_attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c86239173.pcon)
	c:RegisterEffect(e2)
	--summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(86239173,1))
	e3:SetCategory(CATEGORY_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,86239174)
	e3:SetTarget(c86239173.sumtg)
	e3:SetOperation(c86239173.sumop)
	c:RegisterEffect(e3)
end
function c86239173.matfilter(c)
	return c:IsRace(RACE_DRAGON+RACE_DINOSAUR)
end
function c86239173.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c86239173.pfilter(c,tp)
	return not c:IsForbidden() and c:IsType(TYPE_FIELD) and c:CheckUniqueOnField(tp)
end
function c86239173.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c86239173.pfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,tp) end
end
function c86239173.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c86239173.pfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc=Duel.GetFieldCard(tp,LOCATION_FZONE,0)
		if fc then
			Duel.SendtoGrave(fc,REASON_RULE)
			Duel.BreakEffect()
		end
		Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
	end
end
function c86239173.pcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler()
	return ec:IsStatus(STATUS_SPSUMMON_TURN)
end
function c86239173.sumfilter(c)
	return c:IsRace(RACE_DRAGON+RACE_DINOSAUR) and c:IsSummonable(true,nil)
end
function c86239173.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c86239173.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c86239173.sumop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c86239173.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
