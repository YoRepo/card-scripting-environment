--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 电豪灵蜥  (ID: 40894584)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Reptile
-- Level 4
-- ATK 1500 | DEF 200
--
-- Effect Text:
-- ①：「电豪灵蜥」在自己场上只能有1张表侧表示存在。
-- ②：自己场上有魔法师族怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ③：这张卡被战斗·效果破坏送去墓地时才能发动。从卡组把「电豪灵蜥」以外的1只攻击力1500/守备力200的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ジゴバイト
function c40894584.initial_effect(c)
	c:SetUniqueOnField(1,0,40894584)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c40894584.spcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40894584,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c40894584.condition)
	e2:SetTarget(c40894584.target)
	e2:SetOperation(c40894584.operation)
	c:RegisterEffect(e2)
end
function c40894584.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c40894584.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c40894584.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c40894584.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c40894584.filter(c,e,tp)
	return c:IsAttack(1500) and c:IsDefense(200) and not c:IsCode(40894584) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c40894584.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c40894584.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c40894584.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c40894584.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
