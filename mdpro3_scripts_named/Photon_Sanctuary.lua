--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 光子圣域  (ID: 17418744)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 85
--
-- Effect Text:
-- 这张卡发动的回合，自己不是光属性怪兽不能召唤·反转召唤·特殊召唤。
-- ①：在自己场上把2只「光子衍生物」（雷族·光·4星·攻2000/守0）守备表示特殊召唤。这衍生物不能攻击，也不能作为同调素材。
--[[ __CARD_HEADER_END__ ]]

--フォトン・サンクチュアリ
function c17418744.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c17418744.cost)
	e1:SetTarget(c17418744.target)
	e1:SetOperation(c17418744.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(17418744,ACTIVITY_SUMMON,c17418744.counterfilter)
	Duel.AddCustomActivityCounter(17418744,ACTIVITY_SPSUMMON,c17418744.counterfilter)
	Duel.AddCustomActivityCounter(17418744,ACTIVITY_FLIPSUMMON,c17418744.counterfilter)
end
function c17418744.counterfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c17418744.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(17418744,tp,ACTIVITY_SUMMON)==0
		and Duel.GetCustomActivityCount(17418744,tp,ACTIVITY_SPSUMMON)==0
		and Duel.GetCustomActivityCount(17418744,tp,ACTIVITY_FLIPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c17418744.sumlimit)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	Duel.RegisterEffect(e3,tp)
end
function c17418744.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsAttribute(0x6f)
end
function c17418744.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,17418745,0x55,TYPES_TOKEN_MONSTER,2000,0,4,RACE_THUNDER,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c17418744.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,17418745,0x55,TYPES_TOKEN_MONSTER,2000,0,4,RACE_THUNDER,ATTRIBUTE_LIGHT,POS_FACEUP_DEFENSE) then
		for i=1,2 do
			local token=Duel.CreateToken(tp,17418745)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e1,true)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e2,true)
		end
		Duel.SpecialSummonComplete()
	end
end
