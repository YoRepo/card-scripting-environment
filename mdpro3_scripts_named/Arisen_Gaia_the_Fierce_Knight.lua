--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 觉醒的暗黑骑士 盖亚  (ID: 29904964)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 2300 | DEF 2100
-- Setcode: 189
--
-- Effect Text:
-- 「觉醒的暗黑骑士 盖亚」的②的效果1回合只能使用1次。
-- ①：对方场上的怪兽数量比自己场上的怪兽多的场合，这张卡可以不用解放作召唤。
-- ②：这张卡被解放的场合才能发动。从自己的手卡·墓地选1只「混沌战士」怪兽特殊召唤。
-- ③：「混沌战士」怪兽的仪式召唤进行的场合，可以作为需要的等级数值的怪兽之内的1只，把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--覚醒の暗黒騎士ガイア
function c29904964.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29904964,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c29904964.ntcon)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29904964,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,29904964)
	e2:SetTarget(c29904964.sptg)
	e2:SetOperation(c29904964.spop)
	c:RegisterEffect(e2)
	--ritual material
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	e3:SetValue(c29904964.mtval)
	c:RegisterEffect(e3)
end
function c29904964.ntcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
end
function c29904964.spfilter(c,e,tp)
	return c:IsSetCard(0x10cf) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29904964.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29904964.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c29904964.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c29904964.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c29904964.mtval(e,c)
	return c:IsSetCard(0x10cf)
end
