--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 文具电子人004  (ID: 22227683)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 500 | DEF 500
-- Setcode: 171
--
-- Effect Text:
-- ①：这张卡和对方怪兽进行战斗的伤害计算时才能发动。从卡组把「文具电子人004」以外的1只「文具电子人」怪兽送去墓地，这张卡的攻击力·守备力只在那次伤害计算时上升送去墓地的那只怪兽的等级×500。这个效
-- 果的发动后，直到回合结束时对方受到的战斗伤害变成0。
-- ②：这张卡战斗破坏对方怪兽的场合才能发动。从自己的手卡·墓地选2只等级不同的「文具电子人」怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ブンボーグ004
function c22227683.initial_effect(c)
	--atk/def up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e1:SetCondition(c22227683.condition)
	e1:SetTarget(c22227683.target)
	e1:SetOperation(c22227683.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c22227683.sptg)
	e2:SetOperation(c22227683.spop)
	c:RegisterEffect(e2)
end
function c22227683.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil
end
function c22227683.tgfilter(c)
	return c:IsSetCard(0xab) and c:IsType(TYPE_MONSTER) and not c:IsCode(22227683) and c:IsAbleToGrave()
end
function c22227683.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c22227683.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c22227683.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c22227683.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE)
		and c:IsRelateToBattle() and c:IsFaceup() then
		local lv=tc:GetLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(lv*500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetValue(1)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c22227683.spfilter1(c,e,tp)
	return c:IsSetCard(0xab) and c:IsType(TYPE_MONSTER)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
		and Duel.IsExistingMatchingCard(c22227683.spfilter2,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,c,e,tp,c:GetLevel())
end
function c22227683.spfilter2(c,e,tp,lv)
	return c:IsSetCard(0xab) and c:IsType(TYPE_MONSTER) and not c:IsLevel(lv) and c:IsLevelAbove(1)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c22227683.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsExistingMatchingCard(c22227683.spfilter1,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c22227683.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c22227683.spfilter1),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,e,tp)
	if g1:GetCount()>0 then
		local tc=g1:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c22227683.spfilter2),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,tc,e,tp,tc:GetLevel())
		g1:Merge(g2)
		Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
