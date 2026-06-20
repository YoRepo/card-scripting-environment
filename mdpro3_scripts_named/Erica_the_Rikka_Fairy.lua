--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 六花精 欧石楠  (ID: 7407724)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Plant
-- Level 6
-- ATK 2400 | DEF 1000
-- Setcode: 321
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡以外的自己的植物族怪兽进行战斗的攻击宣言时，把手卡·场上的这张卡解放才能发动。那只自己怪兽的攻击力·守备力直到回合结束时上升1000。
-- ②：这张卡在墓地存在的状态，自己场上的植物族怪兽被解放的场合才能发动。这张卡守备表示特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--六花精エリカ
function c7407724.initial_effect(c)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7407724,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e1:SetCountLimit(1,7407724)
	e1:SetCondition(c7407724.atkcon)
	e1:SetCost(c7407724.atkcost)
	e1:SetOperation(c7407724.atkop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7407724,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_RELEASE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,7407725)
	e2:SetCondition(c7407724.spcon)
	e2:SetTarget(c7407724.sptg)
	e2:SetOperation(c7407724.spop)
	c:RegisterEffect(e2)
end
function c7407724.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not ac:IsControler(tp) then ac,bc=bc,ac end
	e:SetLabelObject(ac)
	return ac and ac:IsControler(tp) and ac:IsFaceup() and ac:IsRace(RACE_PLANT) and ac~=c
end
function c7407724.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c7407724.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() and tc:IsFaceup() and tc:IsControler(tp) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
function c7407724.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousRaceOnField()&RACE_PLANT~=0
end
function c7407724.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c7407724.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function c7407724.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c7407724.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)~=0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
			e1:SetValue(LOCATION_REMOVED)
			c:RegisterEffect(e1)
		end
	end
end
