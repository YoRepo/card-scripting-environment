--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 帮一把骑士  (ID: 86039057)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1700 | DEF 100
--
-- Effect Text:
-- 这张卡在墓地存在，自己手卡是0张的场合，对方怪兽的攻击宣言时才能发动。这张卡从墓地特殊召唤，战斗阶段结束。「帮一把骑士」的效果在决斗中只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--タスケナイト
function c86039057.initial_effect(c)
	--end battle phase
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86039057,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,86039057+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(c86039057.condition)
	e1:SetTarget(c86039057.target)
	e1:SetOperation(c86039057.operation)
	c:RegisterEffect(e1)
end
function c86039057.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp) and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c86039057.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c86039057.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
