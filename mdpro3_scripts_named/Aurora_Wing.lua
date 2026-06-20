--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 极光翼鸟  (ID: 70089580)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Winged Beast
-- Level 4
-- ATK 1200 | DEF 1600
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，这张卡可以表侧攻击表示特殊召唤。「极光翼鸟」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--オーロラ・ウィング
function c70089580.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70089580,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1,70089580)
	e1:SetCondition(c70089580.condition)
	e1:SetTarget(c70089580.target)
	e1:SetOperation(c70089580.operation)
	c:RegisterEffect(e1)
end
function c70089580.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c70089580.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c70089580.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
