--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 超重型炮塔列车 破天巨爱  (ID: 26096328)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Machine
-- Rank 11
-- ATK 4000 | DEF 4000
--
-- Effect Text:
-- 11星怪兽×3
-- 「超重型炮塔列车 破天巨爱」1回合1次也能在自己场上的机械族·10阶的超量怪兽上面重叠来超量召唤。
-- ①：1回合1次，把这张卡1个超量素材取除才能发动。这张卡的攻击力·守备力上升2000。这个效果的发动后，直到回合结束时自己不用这张卡不能攻击宣言。
-- ②：这张卡在同1次的战斗阶段中可以向怪兽作出最多有这张卡的超量素材数量＋1次的攻击。
--[[ __CARD_HEADER_END__ ]]

--超弩級砲塔列車ジャガーノート・リーベ
function c26096328.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,11,3,c26096328.ovfilter,aux.Stringid(26096328,0),3,c26096328.xyzop)
	c:EnableReviveLimit()
	--boost
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26096328,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c26096328.atkcost)
	e1:SetOperation(c26096328.atkop)
	c:RegisterEffect(e1)
	--multi attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e2:SetValue(c26096328.raval)
	c:RegisterEffect(e2)
end
function c26096328.ovfilter(c)
	return c:IsFaceup() and c:GetRank()==10 and c:IsRace(RACE_MACHINE)
end
function c26096328.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,26096328)==0 end
	Duel.RegisterFlagEffect(tp,26096328,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c26096328.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c26096328.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(2000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
	local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_CANNOT_ATTACK)
	e0:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e0:SetTargetRange(LOCATION_MZONE,0)
	e0:SetTarget(c26096328.ftarget)
	e0:SetLabel(c:GetFieldID())
	e0:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e0,tp)
end
function c26096328.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c26096328.raval(e,c)
	return e:GetHandler():GetOverlayCount()
end
