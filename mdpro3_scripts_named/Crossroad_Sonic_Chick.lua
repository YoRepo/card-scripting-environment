--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 交叉路小走鹃  (ID: 80054655)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Winged Beast
-- Level 1
-- ATK 300 | DEF 300
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：调整被送去自己墓地的场合才能发动（伤害步骤也能发动）。这张卡从手卡·墓地特殊召唤。除这张卡外的「废品战士」或者有那个卡名记述的怪兽在场上存在的场合，可以再把对方场上的攻击力1900以上的怪兽全部变
-- 成守备表示。这个效果特殊召唤的这张卡从场上离开的场合除外。这个回合，自己不是同调怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--クロスロードランナー
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,60800381)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_GRAVE+LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
end
function s.cfilter(c,tp)
	return c:GetOwner()==tp and c:IsType(TYPE_TUNER)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.pcfilter(c)
	return c:IsFaceup() and (c:IsCode(60800381) or c:IsType(TYPE_MONSTER) and aux.IsCodeListed(c,60800381))
end
function s.posfilter(c)
	return c:IsAttackPos() and c:IsCanChangePosition() and c:IsAttackAbove(1900)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() and aux.NecroValleyFilter()(c)
		and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		c:RegisterEffect(e1)
		if Duel.IsExistingMatchingCard(s.pcfilter,tp,LOCATION_ONFIELD,0,1,c)
			and Duel.IsExistingMatchingCard(s.posfilter,tp,0,LOCATION_MZONE,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
			local g=Duel.GetMatchingGroup(s.posfilter,tp,0,LOCATION_MZONE,nil)
			if g:GetCount()>0 then
				Duel.BreakEffect()
				Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
			end
		end
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetTargetRange(1,0)
	e2:SetTarget(s.splimit)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function s.splimit(e,c)
	return not c:IsType(TYPE_SYNCHRO) and c:IsLocation(LOCATION_EXTRA)
end
