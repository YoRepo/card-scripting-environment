--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 蜂军-革命之大游击阔头枪蜂  (ID: 35057188)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Insect
-- Level 12
-- ATK 3000 | DEF 2000
-- Setcode: 303
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡只要在怪兽区域存在，不会被效果破坏。
-- ②：自己场上的昆虫族同调怪兽的攻击力上升自己的除外状态的昆虫族怪兽数量×200。
-- ③：这张卡被除外的场合才能发动。这张卡特殊召唤。那之后，可以把最多有自己的除外状态的昆虫族怪兽数量的对方场上的卡破坏。那个场合，再给与对方破坏数量×500伤害。
--[[ __CARD_HEADER_END__ ]]

--B・F－革命のグラン・パルチザン
local s,id,o=GetID()
function s.initial_effect(c)
	--Synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.atktg)
	e2:SetValue(s.atkval)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_REMOVE)
	e3:SetCountLimit(1,id)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
end
function s.atktg(e,c)
	return c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_INSECT)
end
function s.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(s.atkfilter,c:GetControler(),LOCATION_REMOVED,0,nil)*200
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local ct=Duel.GetMatchingGroupCount(s.atkfilter,tp,LOCATION_REMOVED,0,nil)
		local dg=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,nil)
		if ct>0 and #dg>0 and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local sg=dg:Select(tp,1,ct,nil)
			Duel.HintSelection(sg)
			local dam=Duel.Destroy(sg,REASON_EFFECT)
			if dam>0 then
				Duel.BreakEffect()
				Duel.Damage(1-tp,dam*500,REASON_EFFECT)
			end
		end
	end
end
