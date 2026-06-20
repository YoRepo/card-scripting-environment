--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 双龙降临  (ID: 13166648)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方的超量怪兽的直接攻击宣言时才能发动。从额外卡组把1只龙族·光属性的超量怪兽表侧攻击表示特殊召唤，攻击对象转移为那只怪兽进行伤害计算。这个效果特殊召唤的怪兽的攻击力变成和攻击怪兽的攻击力相同数值，效
-- 果无效化。「双龙降临」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--双龍降臨
function c13166648.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCountLimit(1,13166648+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c13166648.condition)
	e1:SetTarget(c13166648.target)
	e1:SetOperation(c13166648.activate)
	c:RegisterEffect(e1)
end
function c13166648.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsType(TYPE_XYZ) and tc:IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c13166648.filter(c,e,tp)
	return c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_XYZ)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c13166648.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13166648.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c13166648.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c13166648.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	local ss=false
	local a=Duel.GetAttacker()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK) then
		ss=true
		if a:IsRelateToBattle() and a:IsFaceup() then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetValue(a:GetAttack())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_EFFECT)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e3)
		end
	end
	Duel.SpecialSummonComplete()
	if ss then
		Duel.CalculateDamage(a,tc)
	end
end
