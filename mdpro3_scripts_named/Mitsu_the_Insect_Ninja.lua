--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 虫之忍者-蜜  (ID: 67282505)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Insect
-- Level 2
-- ATK 200 | DEF 2100
-- Setcode: 43
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上有「忍者」卡或者里侧守备表示怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：对方把怪兽的效果发动时，以自己场上1只里侧守备表示怪兽为对象才能发动。那只怪兽变成表侧守备表示，这张卡变成里侧守备表示。作为对象的怪兽是「虫之忍者-蜜」以外的「忍者」怪兽的场合，再把那个对方的所发
-- 动的效果无效。
--[[ __CARD_HEADER_END__ ]]

--蟲の忍者－蜜
local s,id,o=GetID()
function s.initial_effect(c)
	--spsummon
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
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_DISABLE+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.condition)
	e2:SetTarget(s.target)
	e2:SetOperation(s.operation)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b) or c:IsLocation(LOCATION_MZONE) and c:IsPosition(POS_FACEDOWN_DEFENSE)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) end
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
		and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsPosition(POS_FACEDOWN_DEFENSE) end
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(Card.IsPosition,tp,LOCATION_MZONE,0,1,nil,POS_FACEDOWN_DEFENSE)
		and c:IsCanTurnSet() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEDOWN)
	local g=Duel.SelectTarget(tp,Card.IsPosition,tp,LOCATION_MZONE,0,1,1,nil,POS_FACEDOWN_DEFENSE)
	g:AddCard(c)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,2,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsLocation(LOCATION_MZONE) and tc:IsFacedown()
		and Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)>0 then
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) and c:IsFaceup() and c:IsLocation(LOCATION_MZONE)
			and Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)>0
			and tc:IsSetCard(0x2b) and not tc:IsCode(id) then
			Duel.BreakEffect()
			Duel.NegateEffect(ev)
		end
	end
end
