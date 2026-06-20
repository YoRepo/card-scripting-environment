--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 二重防御者  (ID: 44883600)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有表侧守备表示怪兽2只以上存在的场合，对方怪兽的攻击宣言时才能发动。把那1只对方怪兽的攻击无效。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ダブル・ディフェンダー
function c44883600.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44883600,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c44883600.condition)
	e2:SetTarget(c44883600.target)
	e2:SetOperation(c44883600.activate)
	c:RegisterEffect(e2)
end
function c44883600.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(Card.IsPosition,tp,LOCATION_MZONE,0,2,nil,POS_FACEUP_DEFENSE)
end
function c44883600.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c44883600.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.NegateAttack()
	end
end
