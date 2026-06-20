--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 机关傀儡-暗影触摸者  (ID: 34620088)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 1000 | DEF 1000
-- Setcode: 4227
--
-- Effect Text:
-- 这张卡不会被战斗破坏。此外，这张卡在墓地存在，对方怪兽的直接攻击让自己受到战斗伤害时才能发动。这张卡从墓地表侧攻击表示特殊召唤，自己受到1000分伤害。「机关傀儡-暗影触摸者」的这个效果1回合只能使用
-- 1次。成为超量素材的这张卡被送去墓地的场合，不去墓地从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－シャドーフィーラー
function c34620088.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34620088,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCountLimit(1,34620088)
	e2:SetCondition(c34620088.spcon)
	e2:SetTarget(c34620088.sptg)
	e2:SetOperation(c34620088.spop)
	c:RegisterEffect(e2)
	if not c34620088.global_check then
		c34620088.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
		ge1:SetTargetRange(LOCATION_OVERLAY,LOCATION_OVERLAY)
		ge1:SetTarget(aux.TargetBoolFunction(Card.IsCode,34620088))
		ge1:SetValue(LOCATION_REMOVED)
		Duel.RegisterEffect(ge1,0)
	end
end
function c34620088.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and eg:GetFirst():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c34620088.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
end
function c34620088.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)~=0 then
		Duel.Damage(tp,1000,REASON_EFFECT)
	end
end
