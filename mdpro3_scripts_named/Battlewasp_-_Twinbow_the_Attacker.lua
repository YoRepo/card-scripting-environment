--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 蜂军-连击之双弩蜂  (ID: 54772065)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 3
-- ATK 1000 | DEF 500
-- Setcode: 303
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己主要阶段才能发动。这张卡从手卡特殊召唤。这个效果的发动后，直到回合结束时自己不是昆虫族怪兽不能从额外卡组特殊召唤。
-- ②：这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--B・F－連撃のツインボウ
function c54772065.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54772065,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,54772065)
	e1:SetTarget(c54772065.sptg)
	e1:SetOperation(c54772065.spop)
	c:RegisterEffect(e1)
	--Double attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c54772065.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c54772065.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c54772065.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c54772065.splimit(e,c)
	return not c:IsRace(RACE_INSECT) and c:IsLocation(LOCATION_EXTRA)
end
