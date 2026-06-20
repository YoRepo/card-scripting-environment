--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 机炮食人魔  (ID: 88931417)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Fiend
-- Level 3
-- ATK 800 | DEF 800
--
-- Effect Text:
-- 这个卡名的①的效果1回合可以使用最多3次。
-- ①：把自己的魔法与陷阱区域的里侧表示卡任意数量送去墓地才能发动。给与对方送去墓地的数量×800伤害。这个效果的发动后，直到回合结束时恶魔族以外的怪兽的效果让对方受到的全部效果伤害变成0。
-- ②：1回合1次，这张卡被选择作为攻击对象时才能发动。给与对方为对方场上的攻击表示怪兽数量×500伤害。那之后，战斗阶段结束。
--[[ __CARD_HEADER_END__ ]]

--ガトリング・オーガ
local s,id,o=GetID()
function s.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(3,id)
	e1:SetCost(s.damcost)
	e1:SetTarget(s.damtg)
	e1:SetOperation(s.damop)
	c:RegisterEffect(e1)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(s.damtg2)
	e2:SetOperation(s.damop2)
	c:RegisterEffect(e2)
end
function s.costfilter(c)
	return c:IsFacedown() and c:IsAbleToGraveAsCost() and c:GetSequence()<5
end
function s.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.costfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.costfilter,tp,LOCATION_SZONE,0,1,5,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetCount())
end
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked() end
	local ct=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*800)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(s.damcon)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function s.damcon(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 and re and re:IsActiveType(TYPE_MONSTER) then
		if re:GetHandler():IsRace(RACE_FIEND) then return val else return 0 end
	else
		return val
	end
end
function s.filter(c)
	return c:IsPosition(POS_ATTACK)
end
function s.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,0,LOCATION_MZONE,1,nil) end
	local ct=Duel.GetMatchingGroupCount(s.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*500)
end
function s.damop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(s.filter,tp,0,LOCATION_MZONE,nil)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if Duel.Damage(p,ct*500,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
