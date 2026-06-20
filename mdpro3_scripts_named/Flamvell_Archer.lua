--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 炎狱弓手  (ID: 54326448)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 1000 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- 把自己场上表侧表示存在的1只炎族怪兽解放发动。场上存在的名字带有「炎狱」的怪兽的攻击力直到结束阶段时上升800。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--フレムベル・アーチャー
function c54326448.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54326448,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c54326448.attg)
	e1:SetOperation(c54326448.atop)
	c:RegisterEffect(e1)
end
function c54326448.cfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_PYRO)
		and Duel.IsExistingMatchingCard(c54326448.filter,tp,LOCATION_MZONE,0,1,c)
end
function c54326448.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2c)
end
function c54326448.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c54326448.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c54326448.cfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c54326448.atop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c54326448.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	local c=e:GetHandler()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(800)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
