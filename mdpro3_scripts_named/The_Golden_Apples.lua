--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 芙莉嘉的苹果  (ID: 42671151)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上没有怪兽存在，自己受到战斗伤害时才能发动。自己基本分回复受到的伤害的数值，在自己场上把1只「邪精衍生物」（恶魔族·暗·1星·攻/守?）特殊召唤。这衍生物的攻击力·守备力变成和这个效果让自己
-- 回复的数值相同。
--[[ __CARD_HEADER_END__ ]]

--フリッグのリンゴ
function c42671151.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c42671151.condition)
	e1:SetTarget(c42671151.target)
	e1:SetOperation(c42671151.activate)
	c:RegisterEffect(e1)
end
function c42671151.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c42671151.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,42671152,0,TYPES_TOKEN_MONSTER,-2,-2,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c42671151.activate(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.Recover(tp,ev,REASON_EFFECT)
	if rec~=ev or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,42671152,0,TYPES_TOKEN_MONSTER,-2,-2,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,42671152)
	if Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(ev)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		token:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE)
		token:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end
