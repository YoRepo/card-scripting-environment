--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔弹-血色之冠  (ID: 47810543)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 264
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：「魔弹-血色之冠」在自己场上只能有1张表侧表示存在。
-- ②：自己·对方的主要阶段才能发动。从手卡把1只「魔弹」怪兽特殊召唤。和这个效果让怪兽特殊召唤的区域相同纵列的对方的主要怪兽区域没有使用的场合，那个区域直到回合结束时不能使用。
--[[ __CARD_HEADER_END__ ]]

--魔弾－ブラッディ・クラウン
function c47810543.initial_effect(c)
	c:SetUniqueOnField(1,0,47810543)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(47810543,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,47810543)
	e2:SetCondition(c47810543.condition)
	e2:SetTarget(c47810543.target)
	e2:SetOperation(c47810543.operation)
	c:RegisterEffect(e2)
end
function c47810543.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function c47810543.filter(c,e,tp)
	return c:IsSetCard(0x108) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c47810543.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c47810543.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c47810543.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c47810543.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)>0 then
		local seq=4-g:GetFirst():GetSequence()
		if Duel.CheckLocation(1-tp,LOCATION_MZONE,seq) then
			local val=aux.SequenceToGlobal(1-tp,LOCATION_MZONE,seq)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_DISABLE_FIELD)
			e1:SetValue(val)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
