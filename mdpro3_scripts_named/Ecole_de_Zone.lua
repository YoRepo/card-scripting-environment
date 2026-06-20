--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 忘我画派  (ID: 60514625)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：回合玩家只对怪兽1只的召唤·反转召唤·特殊召唤成功的场合发动。那只怪兽破坏，那个控制者在那个自身场上把1只「假面衍生物」（魔法师族·暗·1星·攻/守?）特殊召唤。这衍生物攻击力·守备力变成和这个效
-- 果破坏的怪兽的各自数值相同，不能直接攻击。
-- ②：表侧表示的这张卡从场上离开的场合场上的「假面衍生物」全部破坏。
--[[ __CARD_HEADER_END__ ]]

--エコール・ド・ゾーン
function c60514625.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60514625,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1,60514625)
	e1:SetCondition(c60514625.tkcon)
	e1:SetTarget(c60514625.tktg)
	e1:SetOperation(c60514625.tkop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EVENT_LEAVE_FIELD_P)
	e4:SetOperation(c60514625.desop)
	c:RegisterEffect(e4)
end
function c60514625.tkcon(e,tp,eg,ep,ev,re,r,rp)
	if #eg~=1 then return false end
	local tc=eg:GetFirst()
	return tc:IsSummonPlayer(Duel.GetTurnPlayer())
end
function c60514625.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=eg:GetFirst()
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c60514625.tkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=eg:GetFirst()
	local p=tc:GetControler()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0
		and Duel.GetLocationCount(p,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(p,60514626,0,TYPES_TOKEN_MONSTER,-2,-2,1,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
		local atk=tc:GetPreviousAttackOnField()
		local def=tc:GetPreviousDefenseOnField()
		local token=Duel.CreateToken(tp,60514626)
		if Duel.SpecialSummonStep(token,0,p,p,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetValue(atk)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SET_DEFENSE)
			e2:SetValue(def)
			token:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
			e3:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e3)
		end
	end
	Duel.SpecialSummonComplete()
end
function c60514625.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsFacedown() then return end
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,60514626)
	Duel.Destroy(g,REASON_EFFECT)
end
