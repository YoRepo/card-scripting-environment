--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 铁汉斯  (ID: 41916534)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1200 | DEF 800
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡召唤·反转召唤·特殊召唤成功的场合才能发动。从卡组把1只「铁骑士」特殊召唤。这个效果的处理时场地区域没有「急流山的金宫」存在的场合，直到回合结束时自己不能从额外卡组把怪兽特殊召唤。
-- ②：场地区域有「急流山的金宫」存在的场合，这张卡的攻击力上升自己场上的「铁骑士」数量×1000。
--[[ __CARD_HEADER_END__ ]]

--鉄のハンス
function c41916534.initial_effect(c)
	aux.AddCodeList(c,72283691)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41916534,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,41916534)
	e1:SetTarget(c41916534.sptg)
	e1:SetOperation(c41916534.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetCondition(c41916534.atkcon)
	e4:SetValue(c41916534.value)
	c:RegisterEffect(e4)
end
function c41916534.filter(c,e,tp)
	return c:IsCode(73405179) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c41916534.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c41916534.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c41916534.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c41916534.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	if not Duel.IsEnvironment(72283691,PLAYER_ALL,LOCATION_FZONE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c41916534.splimit)
		Duel.RegisterEffect(e1,tp)
	end
end
function c41916534.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end
function c41916534.atkcon(e)
	return Duel.IsEnvironment(72283691,PLAYER_ALL,LOCATION_FZONE)
end
function c41916534.atkfilter(c)
	return c:IsFaceup() and c:IsCode(73405179)
end
function c41916534.value(e,c)
	return Duel.GetMatchingGroupCount(c41916534.atkfilter,c:GetControler(),LOCATION_ONFIELD,0,nil)*1000
end
