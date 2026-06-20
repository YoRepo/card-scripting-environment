--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 念动力诅咒  (ID: 16678947)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的念动力族怪兽被对方怪兽的攻击破坏送去墓地时才能发动。那个时候进行攻击的1只对方怪兽破坏，给与对方基本分破坏的自己的念动力族怪兽等级×300的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--カース・サイキック
function c16678947.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c16678947.condition)
	e1:SetTarget(c16678947.target)
	e1:SetOperation(c16678947.activate)
	c:RegisterEffect(e1)
end
function c16678947.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return tc:IsPreviousControler(tp) and tc:IsLocation(LOCATION_GRAVE) and tc:IsRace(RACE_PSYCHO)
		and bit.band(tc:GetBattlePosition(),POS_FACEUP)~=0
		and bc:IsRelateToBattle() and bc:IsControler(1-tp) and bc==Duel.GetAttacker()
end
function c16678947.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local tc=eg:GetFirst()
	local bc=Duel.GetAttacker()
	if chk==0 then return bc:IsCanBeEffectTarget(e) end
	local lv=tc:GetLevel()
	e:SetLabel(lv)
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
	if lv~=0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,lv*300)
	end
end
function c16678947.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,e:GetLabel()*300,REASON_EFFECT)
	end
end
