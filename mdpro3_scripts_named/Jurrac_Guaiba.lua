--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 朱罗纪瓜巴龙  (ID: 11012887)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 4
-- ATK 1700 | DEF 400
-- Setcode: 34
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽时才能发动。从卡组把1只攻击力1700以下的「朱罗纪」怪兽特殊召唤。这个效果特殊召唤的怪兽在这个回合不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--ジュラック・グアイバ
function c11012887.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11012887,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdocon)
	e1:SetTarget(c11012887.target)
	e1:SetOperation(c11012887.operation)
	c:RegisterEffect(e1)
end
function c11012887.filter(c,e,tp)
	return c:IsSetCard(0x22) and c:IsAttackBelow(1700) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11012887.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c11012887.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c11012887.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c11012887.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
